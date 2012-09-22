require 'spec_helper' # load lib 

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  context "Database Schema" do
  	it { should have_db_column(:name).of_type(:string) }
  	it { should have_db_column(:email).of_type(:string) }
  end

  context "Associations" do
  	it { should have_many(:relationships) }
  	it { should have_many(:following_users).through(:relationships) }
  	it { should have_many(:reverse_relations).class_name('Relationship') }
  	it { should have_many(:follower_users).through(:reverse_relations) }
  	it { should have_many(:microposts) }
  end

  context "Validations" do
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:email) }
  end

  context "Create new User" do
  	before(:each) do # create user before test
  		#password = '1234'
  		password = Forgery::Basic.password
		@user = User.new(:name => Forgery::Name.full_name, # create user store in instance variable (@user)
		:email => Forgery::Internet.email_address,
		:password => password,
		:password_confirmation => password)
end

# Test case name and email
it "when password is not present" do
	@user.password = @user.password_confirmation = " "
	@user.should_not be_valid
	@user.should have(1).error_on(:password)
end
it "when password doesn't match confirmation" do
	@user.password_confirmation = "mismatch"
	@user.should_not be_valid
	@user.should have(1).error_on(:password)
end
it "with a password that's too short" do
	@user.password = @user.password_confirmation = "123"
	@user.should_not be_valid
	@user.should have(1).error_on(:password)
end

end
end
