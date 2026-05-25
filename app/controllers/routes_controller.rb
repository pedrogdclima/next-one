class RoutesController < ApplicationController
  # before_action :set_route, only: %i[ show edit update destroy star ]
  before_action :set_route, only: %i[ show star ]

  # GET /routes or /routes.json
  def index
    @routes = Route.all
    @starred_routes = session[:starred_routes] || []
  end

  # GET /routes/filter_by_mode
  def filter_by_mode
    @starred_routes = session[:starred_routes] || []
    mode = params[:mode]
    
    @routes = case mode
    when "0"
      Route.where.not(id: (299..400)).where(mode_type: 0)
    when "3"
      Route.where.not(id: (299..400)).where(mode_type: 3)
    when "night"
      Route.where(id: (299..400))
    else
      Route.all
    end
  end

  # GET /routes/1 or /routes/1.json
  def show
    @vehicles = Vehicle.on_route(@route.id)
    @shapes = Shape.for_vehicles(@vehicles)
    @is_starred = route_starred?(@route.id)
  end

  # POST /routes/1/star
  def star
    session[:starred_routes] ||= []
    
    if session[:starred_routes].include?(@route.id)
      session[:starred_routes].delete(@route.id)
      message = "Route removed from starred routes."
      @is_starred = false
    else
      session[:starred_routes] << @route.id
      message = "Route starred successfully!"
      @is_starred = true
    end

    respond_to do |format|
      format.html { redirect_to @route, notice: message }
      format.turbo_stream
      format.json { render json: { starred: is_starred, message: message } }
    end
  end

  # GET /routes/new
  # def new
  #   @route = Route.new
  # end

  # GET /routes/1/edit
  # def edit
  # end

  # POST /routes or /routes.json
  # def create
  #   @route = Route.new(route_params)

  #   respond_to do |format|
  #     if @route.save
  #       format.html { redirect_to @route, notice: "Route was successfully created." }
  #       format.json { render :show, status: :created, location: @route }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @route.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /routes/1 or /routes/1.json
  # def update
  #   respond_to do |format|
  #     if @route.update(route_params)
  #       format.html { redirect_to @route, notice: "Route was successfully updated.", status: :see_other }
  #       format.json { render :show, status: :ok, location: @route }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @route.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /routes/1 or /routes/1.json
  # def destroy
  #   @route.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to routes_path, notice: "Route was successfully destroyed.", status: :see_other }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def route_params
      params.expect(route: [ :id, :short_name, :long_name, :type ])
    end

    # Check if a route is starred in the current session
    def route_starred?(route_id)
      (session[:starred_routes] || []).include?(route_id)
    end
end
