module API
  module Shared
    module Validators
      #
      # アルファベット or 数値
      #
      class AlphaNumeric < Grape::Validations::Validator
        def validate_param!(attr_name, params)
          unless params[attr_name] =~ /^[[:alnum:]]+$/
            raise Grape::Exceptions::Validation,
              param: @scope.full_name(attr_name),
              message: "must consist of alpha-numeric characters"
          end
        end
      end

      #
      # 文字列長最大指定（指定された値より大きければエラー）
      #
      class MaxLength < Grape::Validations::SingleOptionValidator
        def validate_param!(attr_name, params)
          unless params[attr_name].length <= @option
            raise Grape::Exceptions::Validation,
              param: @scope.full_name(attr_name),
              message: "must be at the most #{@option} characters long"
          end
        end
      end

      #
      # 文字列長最小指定（指定された値より小さければエラー）
      #
      class MinLength < Grape::Validations::SingleOptionValidator
        def validate_param!(attr_name, params)
          unless params[attr_name].length >= @option
            raise Grape::Exceptions::Validation,
              param: @scope.full_name(attr_name),
              message: "must be at the most #{@option} characters long"
          end
        end
      end

    end
  end
end