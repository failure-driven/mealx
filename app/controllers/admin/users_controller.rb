module Admin
  class UsersController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    def send_user_registration
      # TODO: add a one time token for signin
      UserMailer
        .with(user: requested_resource)
        .user_registration
        .deliver_later
      redirect_to admin_user_path(requested_resource)
    end

    def send_admin_invitation
      # TODO: add a one time token for signin without calling the protected token generator
      # token = requested_resource.send(:set_reset_password_token)
      # requested_resource.send_reset_password_instructions
      UserMailer
        .with(user: requested_resource)
        .admin_invitation
        .deliver_later
      redirect_to admin_user_path(requested_resource)
    end

    def send_beta_invitation
      # TODO: add a one time token for signin as well
      UserMailer
        .with(
          user: requested_resource,
          reset_token: requested_resource.send(:set_reset_password_token),
          token: generate_jwt_token_for(requested_resource),
        )
        .user_beta_invitation
        .deliver_later
      redirect_to admin_user_path(requested_resource)
    end

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    def scoped_resource
      return resource_class if current_user.user_actions&.dig("admin", "can_administer")

      super.where(id: current_user)
      #   if current_user.super_admin?
      #     resource_class
      #   else
      #     resource_class.with_less_stuff
      #   end
    end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    private

    def generate_jwt_token_for(resource)
      JWT.encode({
                   id: resource.id,
                   exp: 1.days.from_now.to_i,
                 }, Rails.application.secrets.secret_key_base,)
    end
  end
end
