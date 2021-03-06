require "reform/form/validation/unique_validator"

class JobApplication < ActiveRecord::Base
  class Apply < Trailblazer::Operation
    include Model
    model JobApplication, :create

    policy Session::Policy, :apply? # will create Policy instance
    # policy :apply? # use injected policy object

    contract do
      property :job_id
      property :user_id
      property :status
      property :message
      validates :job_id, :user_id, presence: true # maybe no sense
      validates :user_id, unique: {scope: :job_id} #already in policy.apply?
    end

    def process(params)
      validate(params)do
        contract.save
      end
    end

  end
end