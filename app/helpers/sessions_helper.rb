module SessionsHelper
  include SimpleAuthenticate

  authenticate :user
end
