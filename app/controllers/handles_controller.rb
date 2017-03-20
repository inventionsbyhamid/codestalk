class HandlesController < ApplicationController
  before_action :set_handle, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /codechef_ids
  # GET /codechef_ids.json
  def index
    @codechef_ids = current_user.handles
  end

  # GET /codechef_ids/1
  # GET /codechef_ids/1.json
  def show
  end

  # GET /codechef_ids/new
  def new
    @codechef_id = Handle.new
  end

  # GET /codechef_ids/1/edit
  def edit
  end

  # POST /codechef_ids
  # POST /codechef_ids.json
  def create
    @codechef_id = Handle.find_by_username(params[:handle][:username])
    if @codechef_id
       
      if @codechef_id.users.exists?(current_user)
        redirect_to root_path, notice: "You have already added #{@codechef_id.username} for tracking"
      else
      @codechef_id.users<<current_user
      @codechef_id.save!
      redirect_to @codechef_id, notice: "#{@codechef_id.username} was successfully added."
      end
    else
    @codechef_id = Handle.new(handle_params)
    @codechef_id.users<<current_user
    if @codechef_id[:team] == true
      url = "https://www.codechef.com/teams/view/#{@codechef_id.username}"
    else
      url = "https://www.codechef.com/users/#{@codechef_id.username}"
    end
    status = 1
    until status == 200 do
      begin
        r = HTTParty.get(url,:verify => false,timeout: 5,follow_redirects: false )
        puts r.code
      if r.code == 200
        status = 200
      elsif r.code == 302
        redirect_to new_handle_path , notice: "#{@codechef_id.username} is not a valid codechef id"
        return
      end
      rescue HTTParty::Error,Net::OpenTimeout, Net::ReadTimeout
        puts "Error"
      end
    end
    response = Nokogiri::HTML(r.body)
    response = response.css('article p a')
    userSolvedProblems = []
    response.each do | link |
      link["href"] = "https://www.codechef.com#{link["href"]}"
      if link["href"].include?("users") && @codechef_id.team == true
        ;
      else
      userSolvedProblems.push(link.to_s)
      end
    end
    @codechef_id.solved_problems = userSolvedProblems.join(';')

    respond_to do |format|
      if @codechef_id.save
        format.html { redirect_to @codechef_id, notice: "#{@codechef_id.username} was successfully added." }
        format.json { render :show, status: :created, location: @codechef_id }
      else
        format.html { render :new }
        format.json { render json: @codechef_id.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # PATCH/PUT /codechef_ids/1
  # PATCH/PUT /codechef_ids/1.json
  def update
    respond_to do |format|
      if @codechef_id.update(handle_params)
        format.html { redirect_to @codechef_id, notice: "#{@codechef_id.username} was successfully updated." }
        format.json { render :show, status: :ok, location: @codechef_id }
      else
        format.html { render :edit }
        format.json { render json: @codechef_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codechef_ids/1
  # DELETE /codechef_ids/1.json
  def destroy
    user_to_be_removed_from_association = @codechef_id.users.find(current_user.id)
    if user_to_be_removed_from_association
      @codechef_id.users.delete(user_to_be_removed_from_association)
      if @codechef_id.users.blank?
        @codechef_id.destroy
      end
    end
    respond_to do |format|
      format.html { redirect_to handles_url, notice: "#{@codechef_id.username} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_handle
      @codechef_id = current_user.handles.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def handle_params
      params.require(:handle).permit(:username,:team)
    end
end
