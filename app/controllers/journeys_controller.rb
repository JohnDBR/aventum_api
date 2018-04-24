class JourneysController < ApplicationController
  before_action :is_admin, only: [:create, :update, :destroy]
  before_action :set_journey, only: [:show, :join_journey, :update, :destroy]

  # GET /journeys
  def index
    render json: @user.journeys
    # paginate json: @user.journeys.by_date, per_page: PER_PAGE
  end

  # POST /journeys/search
  def search
    # paginate json: Student.where('id NOT IN (:id) AND (identity_number LIKE :search OR nick_name LIKE :search OR name LIKE :search)', id: JavClass.find(params[:id]).student_ids, search: "#{params[:search]}%").by_date, per_page: PER_PAGE  
    # paginate json: Journey.where('id NOT IN (:id)', id: @user["id"]), per_page: PER_PAGE
    render json: Journey.where('id NOT IN (:id)', id: User.first.journeys.ids)
  end

  # GET /journeys/:id
  def show
    render json: {journey: @journey, users: @journey.users}
  end

  # POST /journey/:id/join
  def join_journey
    if @journey.users.exists? @user["id"]
      render json: {err: 'Already joined', code: '008'}
    else
      if @user["coins"] < @journey["price"]
        render json: {err: 'Insufficient coins', code: '009'}
      else
        if @user.update({coins: @user["coins"] - @journey["price"]})
          if Transaction.new({user: @user, coins: @journey["price"], status: 'completed', transaction_code: "#{join_params[:code].upcase}", kind: 1}).save
            @journey["capacity"] -= 1
            @user.journeys << @journey
            render json: @journey
          else
            render json: {err: 'Error saving transaction', code: '011'}
          end
        else
          render json: {err: 'Error geting user coins', code: '010'}
        end
      end
    end
  end

  # POST /journey
  def create
    @journey = Journey.new(journey_params)
    if @journey.save
      @user.journeys << @journey
      render json: @journey, status: :created, location: @journey
    else
      render json: @journey.errors, status: :unprocessable_entity
    end
  end

  # PUT /journey
  def update
    if @journey.update(journey_params)
      render json: @journey
    else
      render json: @journey.errors, status: :unprocessable_entity
    end
  end

  # DELETE /journey
  def destroy
    @journey.destroy
  end

  private
    def set_journey
      @journey = Journey.find(params[:id])
    end

    def journey_params
      params.permit(:code, :start, :end, :capacity, :price, :journey_stop, :duration, :tags)
    end

    def search_params
      params.permit(:code, :start, :end, :capacity, :price, :journey_stop, :duration, :tags)
    end

    def join_params
      params.permit(:code)
    end
end