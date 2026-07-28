/**
 * Database types for the HTML Hero schema.
 *
 * These mirror `supabase/migrations/*.sql`. Regenerate with:
 *   npx supabase gen types typescript --project-id <ref> > src/lib/supabase/database.types.ts
 * The checked-in copy keeps `npm run typecheck` working without a live project.
 */

export type Json = string | number | boolean | null | { [key: string]: Json | undefined } | Json[];

export type BlockType =
  | 'objectives'
  | 'prose'
  | 'term'
  | 'callout'
  | 'visual'
  | 'code_example'
  | 'annotated_code'
  | 'comparison'
  | 'interactive_demo'
  | 'media_example'
  | 'progressive_detail'
  | 'checklist'
  | 'summary'
  // Added by migration 0006. These six are the retrieval-practice blocks: each
  // asks the learner to produce something from memory before it shows them
  // anything, which is the difference between practising and reading.
  | 'pretest'
  | 'recall'
  | 'predict_check'
  | 'self_explain'
  | 'worked_example'
  | 'recap';

export type ExerciseKind =
  | 'guided'
  | 'challenge'
  | 'debug'
  | 'project_mission'
  | 'bonus'
  // Added by migration 0006: finish a partly written solution.
  | 'completion';

export type RequirementKind =
  | 'doctype'
  | 'element_present'
  | 'element_absent'
  | 'element_count'
  | 'unique_element'
  | 'attribute_present'
  | 'attribute_absent'
  | 'attribute_value'
  | 'attribute_matches'
  | 'nesting'
  | 'direct_child'
  | 'text_content'
  | 'text_not_empty'
  | 'accessible_name'
  | 'alt_quality'
  | 'label_association'
  | 'heading_order'
  | 'no_duplicate_ids'
  | 'no_inline_script'
  | 'local_media_path'
  | 'no_deprecated_elements'
  | 'valid_nesting'
  // Added by migration 0009. These judge the *resolved* value after the
  // cascade, never the source text — see src/lib/evaluator/css-cascade.ts.
  | 'css_declared'
  | 'css_value'
  | 'css_value_matches'
  | 'css_inherited'
  | 'css_property_absent'
  | 'css_custom_property'
  | 'css_rule_exists'
  | 'css_media_rule'
  | 'css_no_important'
  | 'css_max_specificity';

export type QuestionKind = 'single' | 'multi' | 'true_false';
export type LessonStatus = 'not_started' | 'in_progress' | 'completed';
export type MasteryState = 'untouched' | 'learning' | 'practising' | 'proficient' | 'mastered';
export type XpSource =
  | 'lesson'
  | 'exercise'
  | 'quiz'
  | 'assessment'
  | 'achievement'
  | 'streak'
  | 'project'
  | 'bonus'
  // Added by migration 0006. Present so the enum matches the database; review
  // deliberately awards no XP — see `answerReviewItemAction`.
  | 'review';
export type MediaKind = 'photo' | 'illustration' | 'icon' | 'video' | 'audio' | 'poster' | 'captions';
export type AssessmentKind = 'milestone' | 'final';
export type ExperienceLevel = 'none' | 'some_html' | 'other_language';

type Timestamps = { created_at: string; updated_at: string };

export type SkillRow = Timestamps & {
  id: string;
  slug: string;
  name: string;
  description: string;
  category: string;
  ordinal: number;
}

export type CourseRow = Timestamps & {
  id: string;
  slug: string;
  title: string;
  subtitle: string;
  description: string;
  recommended_days: number;
  recommended_minutes_per_day: number;
  version: string;
  /** Added by 0008_multi_course.sql, when the platform became a programme. */
  ordinal: number;
  accent: string;
  outcome: string;
  is_published: boolean;
}

export type LevelRow = Timestamps & {
  id: string;
  course_id: string;
  slug: string;
  ordinal: number;
  title: string;
  subtitle: string;
  summary: string;
  outcome: string;
  accent: string;
}

export type ModuleRow = Timestamps & {
  id: string;
  level_id: string;
  slug: string;
  ordinal: number;
  title: string;
  summary: string;
  estimated_minutes: number;
  is_milestone: boolean;
}

export type LessonRow = Timestamps & {
  id: string;
  module_id: string;
  slug: string;
  ordinal: number;
  title: string;
  subtitle: string;
  summary: string;
  objectives: string[];
  estimated_minutes: number;
  xp_award: number;
  primary_skill_id: string | null;
  mastery_threshold: number;
}

export type LessonBlockRow = Timestamps & {
  id: string;
  lesson_id: string;
  ordinal: number;
  block_type: BlockType;
  title: string | null;
  body: string | null;
  code: string | null;
  language: string | null;
  media_slug: string | null;
  data: Json;
}

export type ExerciseRow = Timestamps & {
  id: string;
  lesson_id: string;
  slug: string;
  ordinal: number;
  kind: ExerciseKind;
  title: string;
  brief: string;
  starter_code: string;
  reference_solution: string;
  hints: string[];
  xp_award: number;
  difficulty: number;
  skill_id: string | null;
  is_optional: boolean;
}

export type ExerciseRequirementRow = {
  id: string;
  exercise_id: string;
  ordinal: number;
  kind: RequirementKind;
  selector: string | null;
  attribute: string | null;
  expected_value: string | null;
  ancestor_selector: string | null;
  min_count: number | null;
  max_count: number | null;
  message: string;
  hint: string | null;
  weight: number;
  is_critical: boolean;
  /** Media or container query treated as active while checking (0009). */
  condition: string | null;
  created_at: string;
}

export type QuizQuestionRow = Timestamps & {
  id: string;
  lesson_id: string | null;
  assessment_id: string | null;
  slug: string;
  ordinal: number;
  kind: QuestionKind;
  prompt: string;
  explanation: string;
  skill_id: string | null;
  xp_award: number;
}

export type QuizOptionRow = {
  id: string;
  question_id: string;
  ordinal: number;
  label: string;
  is_correct: boolean;
  feedback: string | null;
}

export type LearningMediaRow = Timestamps & {
  id: string;
  slug: string;
  kind: MediaKind;
  title: string;
  description: string;
  path: string;
  width: number | null;
  height: number | null;
  duration_secs: number | null;
  srcset: Json;
  formats: Json;
  poster_path: string | null;
  captions_path: string | null;
  suggested_alt: string;
  is_decorative_example: boolean;
  tags: string[];
}

export type MediaAttributionRow = {
  id: string;
  media_id: string;
  asset_title: string;
  creator: string | null;
  source: string;
  source_url: string | null;
  licence: string;
  licence_url: string | null;
  attribution_text: string;
  local_path: string;
  retrieved_on: string;
  notes: string | null;
  created_at: string;
}

export type ProjectTemplateRow = Timestamps & {
  id: string;
  slug: string;
  name: string;
  tagline: string;
  description: string;
  audience: string;
  hero_media_slug: string | null;
  page_plan: Json;
  ordinal: number;
}

export type AchievementRow = Timestamps & {
  id: string;
  slug: string;
  name: string;
  description: string;
  icon: string;
  tier: string;
  criteria: Json;
  xp_award: number;
  ordinal: number;
}

export type AssessmentRow = Timestamps & {
  id: string;
  level_id: string | null;
  course_id: string | null;
  slug: string;
  kind: AssessmentKind;
  title: string;
  description: string;
  pass_score: number;
  xp_award: number;
  ordinal: number;
}

export type ProfileRow = Timestamps & {
  id: string;
  display_name: string;
  avatar_url: string | null;
  theme: string;
  reduced_motion: boolean;
  timezone: string;
  onboarding_completed_at: string | null;
  last_active_at: string | null;
}

export type LearningPlanRow = Timestamps & {
  id: string;
  user_id: string;
  course_id: string;
  minutes_per_day: number;
  study_days: number[];
  target_completion_date: string | null;
  experience: ExperienceLevel;
  project_template_id: string | null;
  recommended_lessons_per_week: number;
  estimated_completion_date: string | null;
  started_on: string;
  is_active: boolean;
}

export type UserLessonProgressRow = Timestamps & {
  id: string;
  user_id: string;
  lesson_id: string;
  status: LessonStatus;
  started_at: string | null;
  completed_at: string | null;
  time_spent_seconds: number;
  visits: number;
  best_score: number | null;
}

export type ExerciseAttemptRow = {
  id: string;
  user_id: string;
  exercise_id: string;
  submitted_code: string;
  passed: boolean;
  score: number;
  results: Json;
  hints_used: number;
  duration_seconds: number;
  created_at: string;
}

export type SavedCodeRow = Timestamps & {
  id: string;
  user_id: string;
  exercise_id: string;
  code: string;
  hints_used: number;
}

export type QuizAttemptRow = {
  id: string;
  user_id: string;
  question_id: string;
  selected_option_ids: string[];
  is_correct: boolean;
  /** Stated before the answer was revealed. Null when not asked. */
  confidence: number | null;
  answered_at: string;
}

// --- Review engine (0006) ---------------------------------------------------

export type ReviewItemKind = 'question' | 'exercise' | 'recall_prompt';
export type ReviewCardStateName = 'new' | 'learning' | 'review' | 'relearning';

export type ReviewItemRow = {
  id: string;
  slug: string;
  kind: ReviewItemKind;
  skill_id: string;
  lesson_id: string | null;
  question_id: string | null;
  exercise_id: string | null;
  prompt: string | null;
  expected_points: string[];
  difficulty: number;
  created_at: string;
  updated_at: string;
}

export type ReviewStateRow = {
  id: string;
  user_id: string;
  review_item_id: string;
  stability: number;
  difficulty: number;
  reps: number;
  lapses: number;
  state: ReviewCardStateName;
  last_reviewed_on: string | null;
  due_on: string | null;
  created_at: string;
  updated_at: string;
}

export type ReviewLogRow = {
  id: string;
  user_id: string;
  review_item_id: string;
  grade: number;
  confidence: number | null;
  retrievability: number | null;
  interval_days: number;
  reviewed_at: string;
}

export type AssessmentAttemptRow = {
  id: string;
  user_id: string;
  assessment_id: string;
  score: number;
  passed: boolean;
  detail: Json;
  created_at: string;
}

export type UserSkillMasteryRow = Timestamps & {
  id: string;
  user_id: string;
  skill_id: string;
  mastery: number;
  state: MasteryState;
  evidence_count: number;
  correct_count: number;
  needs_practice: boolean;
  last_practised_at: string | null;
}

export type UserProjectRow = Timestamps & {
  id: string;
  user_id: string;
  project_template_id: string | null;
  name: string;
  description: string;
  status: string;
  completion_percent: number;
}

export type ProjectFileRow = Timestamps & {
  id: string;
  project_id: string;
  user_id: string;
  path: string;
  content: string;
  kind: string;
  mission_slug: string | null;
}

export type UserAchievementRow = {
  id: string;
  user_id: string;
  achievement_id: string;
  unlocked_at: string;
}

export type XpTransactionRow = {
  id: string;
  user_id: string;
  amount: number;
  source_type: XpSource;
  source_id: string;
  reason: string;
  created_at: string;
}

export type StudySessionRow = Timestamps & {
  id: string;
  user_id: string;
  study_date: string;
  seconds: number;
  lessons_completed: number;
  exercises_passed: number;
  xp_earned: number;
}

export type CertificateRow = {
  id: string;
  user_id: string;
  course_id: string;
  serial: string;
  recipient_name: string;
  score: number;
  skills_mastered: number;
  issued_at: string;
}

export type CourseOutlineRow = {
  course_id: string;
  course_slug: string;
  level_id: string;
  level_slug: string;
  level_ordinal: number;
  level_title: string;
  module_id: string;
  module_slug: string;
  module_ordinal: number;
  module_title: string;
  is_milestone: boolean;
  lesson_id: string;
  lesson_slug: string;
  lesson_ordinal: number;
  lesson_title: string;
  estimated_minutes: number;
  xp_award: number;
  primary_skill_id: string | null;
}

export type UserProgressOverviewRow = {
  user_id: string;
  total_xp: number;
  lessons_completed: number;
  skills_mastered: number;
  skills_needing_practice: number;
  achievements_unlocked: number;
  total_study_seconds: number;
  last_study_date: string | null;
}

/** Convenience helper: a table definition with Row/Insert/Update shapes. */
type Table<Row, Insert = Partial<Row>, Update = Partial<Row>> = {
  Row: Row;
  Insert: Insert;
  Update: Update;
  Relationships: [];
};

export interface Database {
  public: {
    Tables: {
      skills: Table<SkillRow>;
      skill_prerequisites: Table<{ skill_id: string; prerequisite_skill_id: string }>;
      courses: Table<CourseRow>;
      levels: Table<LevelRow>;
      modules: Table<ModuleRow>;
      module_prerequisites: Table<{ module_id: string; prerequisite_module_id: string }>;
      module_skills: Table<{ module_id: string; skill_id: string; mastery_required: number }>;
      lessons: Table<LessonRow>;
      lesson_blocks: Table<LessonBlockRow>;
      exercises: Table<ExerciseRow>;
      exercise_requirements: Table<ExerciseRequirementRow>;
      quiz_questions: Table<QuizQuestionRow>;
      quiz_options: Table<QuizOptionRow>;
      learning_media: Table<LearningMediaRow>;
      media_attributions: Table<MediaAttributionRow>;
      project_templates: Table<ProjectTemplateRow>;
      achievements: Table<AchievementRow>;
      assessments: Table<AssessmentRow>;
      profiles: Table<ProfileRow>;
      learning_plans: Table<LearningPlanRow>;
      user_lesson_progress: Table<UserLessonProgressRow>;
      exercise_attempts: Table<ExerciseAttemptRow>;
      saved_code: Table<SavedCodeRow>;
      quiz_attempts: Table<QuizAttemptRow>;
      assessment_attempts: Table<AssessmentAttemptRow>;
      user_skill_mastery: Table<UserSkillMasteryRow>;
      user_projects: Table<UserProjectRow>;
      project_files: Table<ProjectFileRow>;
      user_achievements: Table<UserAchievementRow>;
      xp_transactions: Table<XpTransactionRow>;
      study_sessions: Table<StudySessionRow>;
      certificates: Table<CertificateRow>;
      review_items: Table<ReviewItemRow>;
      review_states: Table<ReviewStateRow>;
      review_logs: Table<ReviewLogRow>;
    };
    Views: {
      course_outline: { Row: CourseOutlineRow; Relationships: [] };
      user_progress_overview: { Row: UserProgressOverviewRow; Relationships: [] };
    };
    // The schema defines no RPC functions. This is the shape Supabase's own
    // generator emits for an empty group, and it is required for the schema to
    // satisfy postgrest-js's `GenericSchema` constraint.
    Functions: { [_ in never]: never };
    Enums: {
      block_type: BlockType;
      exercise_kind: ExerciseKind;
      requirement_kind: RequirementKind;
      question_kind: QuestionKind;
      lesson_status: LessonStatus;
      mastery_state: MasteryState;
      xp_source: XpSource;
      media_kind: MediaKind;
      assessment_kind: AssessmentKind;
      experience_level: ExperienceLevel;
    };
    CompositeTypes: { [_ in never]: never };
  };
}
