module API
  class Base < Grape::API

    # バージョンアップ毎にマウントする
  	# mount API::V1::Base
  	# mount API::V2::Base
  	# mount API::V3::Base

  	mount API::V1::Base
  end
end