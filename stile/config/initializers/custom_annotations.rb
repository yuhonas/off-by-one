# NOTE: Purely for conversation purposes with stile, this wouldn't exist in production

Rails.application.config.annotations.register_tags('NOTE') if Rails.env.development?
