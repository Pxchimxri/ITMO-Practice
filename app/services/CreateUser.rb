class CreateUser
  attr_accessor :user
  def initialize(params)
    @user = User.new(name: params[:name], role: params[:role])
  end
  def create
    @user.active= true
  end

  def save
    @user.save
  end


end
