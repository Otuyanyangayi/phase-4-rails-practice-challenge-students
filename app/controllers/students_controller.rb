class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_student_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_exception
    
    def index
        students = Student.all
        render json: students, only: [:name, :major, :age], status: :ok
    end

    def show
        student = Student.find_by(id: params[:id])
        render json: student, only: [:name, :major, :age], status: :ok

    end

    def create
        new_student = Student.create!(student_params)
        render json: new_student, status: :created
    end

    def update
        student = Student.find_by(id: params[:id])
        student.update(student_params)
        render json: student
    end

    def destroy
        student = Student.find_by(id: params[:id])
        student.destroy
        render json: {}, status: :ok

    end


    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_camper_not_found
        render json: { error: "Student not found" }, status: :not_found
      end
    
      def render_unprocessable_entity_exception(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      end

end
