class ApplicationController < ActionController::Base
  
  def render(cell_constant, operation: @operation, model: @operation.model)
    # return super(html:  cell(cell_constant, model), layout: true) # use this to render the page cell with ActionView's layout.
    super(html: cell(cell_constant, model,
      layout: RailsFoundation::Cell::Layout,
      context: { tyrant: tyrant, policy: operation.policy, flash: flash }))
  end

  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end

  def process_params!(params)
    params.merge!(current_user: tyrant.current_user)
  end

  # FIXME: where do we enforce the signed in constrained?
  rescue_from Trailblazer::NotAuthorizedError do |exception|
    if exception.query == :apply?
      flash[:message] = "You have already applied for this job"
    else
      user_not_authorized(params)
    end
  end
  
  def user_not_authorized(params)
    if tyrant.current_user
      flash[:message] = "Not authorized, my friend."
    else
      flash[:notice] = "Need to Sign In or create an account!"
    end
    redirect_to root_path
  end

end
