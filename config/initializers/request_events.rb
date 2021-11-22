# frozen_string_literal: true

ActiveSupport::Notifications.subscribe 'process_action.action_controller' do |_name, started, finished, _unique_id, data|
  RequestMetricService.send(started, finished, data)
end
