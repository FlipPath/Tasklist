# lib/extensions/prototype_ext.rb
# NEEDS to be required manually in rails app)
# Uses debug library from here: http://benalman.com/projects/javascript-debug-console-log/
# This is for jquery library but can be done with prototype as well (Rails 2)

module ActionView::Helpers::PrototypeHelper
  class JavaScriptGenerator
    module GeneratorMethods
      # will trigger a jquery custom event in order to cause
      # some externally defined javascript to occur
      #
      # event_name = "custom:event" (the event to trigger)
      # parameters = { :var => "value" } (the parameters to pass)
      #
      # example: page.trigger "custom:event"
      #
      def trigger(event_name, parameters={})
        parameters.reverse_merge!(:type => event_name)
        self << "$(document).trigger(#{parameters.to_json})"
        self << "debug.info('triggered', #{event_name.inspect}, #{parameters.to_json})" if Rails.env.development?
      end
    end
  end
end