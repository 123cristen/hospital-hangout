# Redefine form methods in form_for 
# to easily customize accross application

# Configure by adding the following to config/application.rb 
# inside the Application class:
# config.autoload_paths += %W( #{config.root}/lib )

# Include in a form using: 
# <%= form_for(@object, builder: FormBuilder) do |f| %>

# Error fields: to enable custom errors include the following in config/application.rb
# config.action_view.field_error_proc Proc.new {|html, instance| html}

class FormBuilder < ActionView::Helpers::FormBuilder
	include ActionView::Helpers::TagHelper
	include ActionView::Helpers::CaptureHelper
	include ActionView::Helpers::TextHelper

	attr_accessor :output_buffer

	ERROR_CLASS = "error"

	# Metaprogramming
	# Implements formatting for each of these fields instead of copy/pasting for each
	%w(email_field text_field password_field).each do |form_method|
		define_method(form_method) do |*args|
			attribute = args[0]
			options = args[1] || {}
			text_field(attribute, options)
		end
	end

	# Include this to generate all html associated with a text field
	def text_field(attribute, options={})
		options[:label] ||= attribute # default text field label
		label_text ||= options.delete(:label).to_s.titleize
		label_options ||= {}
		if errors_on?(attribute)
			label_options[:class] = ERROR_CLASS
			options[:class] = ERROR_CLASS
		end
		content_tag(:div, class: "") do # creates html tags and classes for block
			label(attribute, label_text, label_options) + 
			super(attribute, options) + errors_for_field(attribute)
		end
	end

	# Include this to generate all html associated with a submit button
	def submit(text, options={})
		options[:class] ||= ""	# default classes
		content_tag(:div, class: "") do # creates html tags and classes for block
			super(text, options)
		end
	end

	# Same method as above, using the wrapper below
	# def submit(text, options={})
	# 	options[:class] ||= ""
	# 	wrapper do
	# 		super(text, options)
	# 	end
	# end

	def wrapper(options={}, &block) # Define this method for tags that will be included for all methods above
		content_tag(:div, capture(&block), class: "") 
		# capture encloses the block inside the div, see implementation above
	end

	def errors_on?(attribute)
		objecterrors[:attribute].size > 0
	end

	def errors_for_field(attribute, options={})
		return "" if object.errors[attribute].empty?
		content_tag(:small, object.errors[attribute].to_sentence, class: ERROR_CLASS)
		# object refers to the object passed into the form
	end
end