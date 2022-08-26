class EventsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
        @events = Event.all
        @users = User.all
    end

    def show
        @event = Event.find(params[:id])
    end

    def new
        @event = current_user.events.build
    end

    def create
        @event = current_user.events.build(event_params())

        if @event.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def event_params
        params.require(:event).permit(:name, :date, :location)
    end
end
