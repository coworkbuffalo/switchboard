class MembersController < ApplicationController
  http_basic_authenticate_with name: "coworkbuffalo", password: Switchboard.admin_password

  before_action :set_member, only: [:edit, :update, :destroy]

  def index
    @members = Member.all
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to members_url, notice: 'Member was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(member_params)
      redirect_to members_url, notice: 'Member was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def member_params
      params.require(:member).permit(:name, :phone_number)
    end
end
