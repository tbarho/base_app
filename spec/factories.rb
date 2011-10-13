Factory.define :user do |f|
  f.sequence(:username) { |n| "test#{n}" }
  f.sequence(:email) { |n| "test#{n}@example.com" }
  f.password "secret"
end
