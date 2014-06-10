module API
  module Shared
    module Transaction
      extend ActiveSupport::Concern

      included do

      	before_validation do
      	  ActiveRecord::Base.connection.begin_transaction
      	end

      	after do
      	  begin
      	  	ActiveRecord::Base.connection.commit_transaction unless @error
      	  rescue Exception
            logger.error @error
      	  	ActiveRecord::Base.connection.rollback_transaction
      	  	raise
      	  end
      	end
      end
    end
  end
end