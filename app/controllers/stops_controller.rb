class StopsController < ApplicationController
  # before_action :set_stop, only: %i[ show edit update destroy ]
  before_action :set_stop, only: %i[ show ]

  # GET /stops or /stops.json
  # def index
  #   @stops = Stop.all
  # end

  # GET /stops/1 or /stops/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stop
      @stop = Stop.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def stop_params
      params.expect(stop: [ :id, :code, :name, :lat, :lon ])
    end
end
