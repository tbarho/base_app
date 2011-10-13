Factory.define :user do |f|
  f.sequence(:name) { |n| "test#{n}" }
  f.sequence(:name) { |n| "test#{n}@example.com" }
  f.password "secret"
end
