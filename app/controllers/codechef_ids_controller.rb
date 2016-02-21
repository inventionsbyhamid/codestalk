class CodechefIdsController < ApplicationController
  before_action :set_codechef_id, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /codechef_ids
  # GET /codechef_ids.json
  def index
    @codechef_ids = current_user.codechef_ids
  end

  # GET /codechef_ids/1
  # GET /codechef_ids/1.json
  def show
  end

  # GET /codechef_ids/new
  def new
    @codechef_id = CodechefId.new
  end

  # GET /codechef_ids/1/edit
  def edit
  end

  # POST /codechef_ids
  # POST /codechef_ids.json
  def create
    @codechef_id = CodechefId.new(codechef_id_params)
    @codechef_id.user = current_user
    respond_to do |format|
      if @codechef_id.save
        format.html { redirect_to @codechef_id, notice: 'Codechef was successfully created.' }
        format.json { render :show, status: :created, location: @codechef_id }
      else
        format.html { render :new }
        format.json { render json: @codechef_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codechef_ids/1
  # PATCH/PUT /codechef_ids/1.json
  def update
    respond_to do |format|
      if @codechef_id.update(codechef_id_params)
        format.html { redirect_to @codechef_id, notice: 'Codechef was successfully updated.' }
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
    @codechef_id.destroy
    respond_to do |format|
      format.html { redirect_to codechef_ids_url, notice: 'Codechef was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_codechef_id
      @codechef_id = current_user.codechef_ids.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def codechef_id_params
      params.require(:codechef_id).permit(:username)
    end
end
