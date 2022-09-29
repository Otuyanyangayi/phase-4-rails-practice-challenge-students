class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_exception  
    rescue_from ActiveRecord::RecordNotFound, with: :render_instructor_not_found
    # read    
    def index
        instructors = Instructor.all
        render json: instructors
    end

    # show
    def show 
        instructor = Instructor.find_by(id: params[:id])
        render json: instructor
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = Instructor.find_by( id: params[:id])
        instructor.update(instructor_params)
        render json: instructor
    end

    def destroy
        instructor = Instructor.find_by(id: params[:id])
        instructor.destroy
        render json: {}, status: :ok
       end

    private

    def instructor_params
        params.permit(:name)
    end

    def render_instructor_not_found
        render json: {error: "No instructor found!"}, status: :not_found
    end

    def render_unprocessable_entity_exception(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      end

end
