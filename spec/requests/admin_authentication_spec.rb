require 'spec_helper'

describe "When a user signs in" do

  context "and tries to access an admin resource" do
    
    context "with valid admin priveledges" do
      it "they are allowed to view the resource" do
      end
      it "they are shown the admin tools for that resource" do
      end
    end

    context "without valid admin priveledges" do
      it "they are redirected back to the page they came from" do
      end
      it "they are notified that they do not have permission to view that resource" do
      end
    end    

  end

end
