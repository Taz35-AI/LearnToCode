import { z } from 'zod';

/**
 * Validation schemas shared by client forms and server actions.
 *
 * The same schema runs in both places: the browser gets fast feedback, and the
 * server re-validates because — as Level 6 teaches — client-side validation is
 * a convenience and never a security control.
 */

export const emailSchema = z
  .string()
  .trim()
  .min(1, 'Enter your email address')
  .email('Enter an email address in the format name@example.com');

export const passwordSchema = z
  .string()
  .min(10, 'Use at least 10 characters — length matters more than symbols')
  .max(200, 'That password is too long');

export const displayNameSchema = z
  .string()
  .trim()
  .min(1, 'Enter the name you would like to be called')
  .max(60, 'Please keep your name under 60 characters');

export const registerSchema = z.object({
  displayName: displayNameSchema,
  email: emailSchema,
  password: passwordSchema,
});

export const loginSchema = z.object({
  email: emailSchema,
  password: z.string().min(1, 'Enter your password'),
  next: z.string().optional(),
});

export const forgotPasswordSchema = z.object({ email: emailSchema });

export const resetPasswordSchema = z
  .object({
    password: passwordSchema,
    confirmPassword: z.string(),
  })
  .refine((values) => values.password === values.confirmPassword, {
    message: 'The two passwords do not match',
    path: ['confirmPassword'],
  });

/** ISO weekday numbers: 1 = Monday … 7 = Sunday. */
const studyDaySchema = z.coerce.number().int().min(1).max(7);

export const onboardingSchema = z.object({
  displayName: displayNameSchema,
  minutesPerDay: z.coerce
    .number()
    .int()
    .min(15, 'Choose at least 15 minutes')
    .max(240, 'That is more than most people sustain — choose up to 4 hours'),
  studyDays: z
    .array(studyDaySchema)
    .min(1, 'Choose at least one day you can study')
    .max(7),
  experience: z.enum(['none', 'some_html', 'other_language']),
  targetCompletionDate: z
    .string()
    .optional()
    .refine((value) => !value || !Number.isNaN(Date.parse(value)), 'Enter a valid date'),
  projectTemplateSlug: z.string().min(1, 'Choose a final project'),
});

export const evaluateSchema = z.object({
  exerciseId: z.string().uuid('Unknown exercise'),
  code: z.string().max(120_000, 'That is a very large document — keep exercises under 120KB'),
  hintsUsed: z.coerce.number().int().min(0).max(20).default(0),
  durationSeconds: z.coerce.number().int().min(0).max(86_400).default(0),
});

export const saveCodeSchema = z.object({
  exerciseId: z.string().uuid(),
  code: z.string().max(120_000),
  hintsUsed: z.coerce.number().int().min(0).max(20).default(0),
});

export const answerQuestionSchema = z.object({
  questionId: z.string().uuid(),
  optionIds: z.array(z.string().uuid()).min(1, 'Choose an answer'),
  /**
   * How sure the learner said they were, captured before the answer was shown.
   *
   * Optional at the boundary rather than required, because answers recorded
   * before this existed have none and a stricter schema would reject a replayed
   * request rather than a malformed one. The interface asks for it every time.
   */
  confidence: z.union([z.literal(1), z.literal(2), z.literal(3), z.literal(4)]).optional(),
});

export const completeLessonSchema = z.object({
  lessonId: z.string().uuid(),
  secondsSpent: z.coerce.number().int().min(0).max(86_400).default(0),
});

export const submitAssessmentSchema = z.object({
  assessmentId: z.string().uuid(),
  answers: z
    .array(z.object({ questionId: z.string().uuid(), optionIds: z.array(z.string().uuid()) }))
    .min(1),
});

export const saveProjectFileSchema = z.object({
  path: z
    .string()
    .trim()
    .min(1, 'Enter a file path')
    .max(120)
    .regex(
      /^[a-z0-9][a-z0-9._/-]*\.(html|css|txt|svg|json|vtt)$/,
      'Use lowercase letters, numbers and hyphens, ending in a known file extension',
    ),
  content: z.string().max(200_000),
  missionSlug: z.string().optional(),
});

export const updateSettingsSchema = z.object({
  displayName: displayNameSchema,
  theme: z.enum(['system', 'light', 'dark']),
  reducedMotion: z.coerce.boolean().default(false),
  minutesPerDay: z.coerce.number().int().min(15).max(240),
  studyDays: z.array(studyDaySchema).min(1).max(7),
  targetCompletionDate: z.string().optional(),
});

export type RegisterInput = z.infer<typeof registerSchema>;
export type LoginInput = z.infer<typeof loginSchema>;
export type OnboardingInput = z.infer<typeof onboardingSchema>;

/** The shape every server action returns, so forms can render errors uniformly. */
export interface ActionResult<T = undefined> {
  ok: boolean;
  message?: string;
  /** Field-level messages, keyed by field name. */
  errors?: Record<string, string>;
  data?: T;
}

export function fieldErrors(error: z.ZodError): Record<string, string> {
  const errors: Record<string, string> = {};
  for (const issue of error.issues) {
    const key = issue.path.join('.') || 'form';
    if (!errors[key]) errors[key] = issue.message;
  }
  return errors;
}
