class EventsController < ApplicationController
before_filter :set_current_user
def new 
    # default: render 'new' template
  end
def index
  check_access_user_Admins
  @events = Event.all
end

def show
 check_access_user_Team(params[:id])
 @team = Team.find_by_team(@current_user.user_id)
 @Leagueevents = Event.find_all_by_eventscope(@team[:league_name]) 
 @Globalevents = Event.find_all_by_eventscope('Global Event')
end

def create
    #check_access_user_Admins
    @event = Event.create!(params[:event])
    @league = League.find_by_league_admin(@current_user.user_id)
    if @league
    @event.update_attributes!(:eventscope => @league[:league_name])
    else
    @event.update_attributes!(:eventscope => 'Global Event')
    end
    flash[:notice] = "#{@event.eventdesp} was successfully created."
    redirect_to events_path
  end


def update
     @event_update = Event.find_by_id(params[:id])
     event_name = @event_update.eventdesp
     event_category =@event_update.eventscope
     team_no = @current_user.user_id

	
     Eventregistration.create!(:event_name => event_name,:event_category => event_category,:team_no => team_no)
     flash[:notice] = "#{@event_update.eventdesp} was successfully added."
    redirect_to event_path, :id=> team_no
end


end
