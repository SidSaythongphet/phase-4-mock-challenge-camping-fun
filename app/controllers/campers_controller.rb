class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    # GET '/campers'
    def index
        render json: Camper.all, status: :ok
    end

    # GET '/campers/:id'
        # include activities
        # include error
    def show
        camper = find_camper
        render json: camper, serializer: CamperWithActivitiesSerializer, status: :ok
    end

    # POST '/campers'
        # include error
    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end 

    private

    def find_camper
        Camper.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity 
    end

end
