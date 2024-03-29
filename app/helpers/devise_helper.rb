module DeviseHelper
	def devise_error_messages!
		key = flash
		return "" if resource.errors.empty?

		messages  = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
		sentence = I18n.t("errors.messages.not_saved",
											:count => resource.errors.count,
											:resource => resource.class.model_name.human.downcase)

		html = <<-HTML
		<div class="alert alert-danger">
			<h3 id="error-title">#{sentence}</h3>
			<h3 id="error-body">#{messages}</h3>
		</div>
		HTML

		html.html_safe
	end

	def devise_error_messages?
		resource.errors.empty? ? false : true
	end

end