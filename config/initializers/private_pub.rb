PrivatePub::ViewHelpers.module_eval do
	def subscribe_to(channel)
      subscription = PrivatePub.subscription(:channel => channel)
      content_tag "script", :type => "text/javascript" do
        raw(
          "if(typeof PrivatePub.subscriptions['#{channel}'] === 'undefined') {
            PrivatePub.sign(#{subscription.to_json});
          }")
      end
    end
end