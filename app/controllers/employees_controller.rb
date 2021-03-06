class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]

  # GET /employees or /employees.json
  def index
    @employees = Employee.all.select(:id, :first_name, :last_name, :email, :phone, :salary, :area)
    #@import = Employee::Import.new 
    respond_to do |format|
      format.html
      format.csv { send_data @employees.to_csv, filename: "employees-#{Date.today}.csv" }
    end
  end

  def import
    begin
      if Employee.from_csv(params[:file]).failed_instances.empty? 
        flash[:notice] = "Employees imported successfully"
      else 
        flash[:alert] = "There is a problem with one or more records of your csv file"
      end
    rescue => e
      puts e.message
      flash[:alert] = "There was a problem with your file or your file records."
    end
    redirect_to employees_path
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params.except(:area))
    @employee.area = employee_params[:area].to_i
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
    e_params = employee_params.except(:area)
    e_params.merge!(area: employee_params[:area].to_i)
      if @employee.update(e_params)
        format.html { redirect_to @employee, notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :phone, :email, :salary, :area)
    end
end
