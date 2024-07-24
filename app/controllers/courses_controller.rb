class CoursesController < ApplicationController
  def update
    id = params.fetch("id")
    @the_course = Course.where({ :id => id }).at(0)
    @the_course.title = params.fetch("query_title")
    @the_course.term_offered = params.fetch("query_term_offered")

    if @the_course.valid?
      @the_course.save
      redirect_to("/courses/#{@the_course.id}", { :notice => "Course updated successfully."} )
    else
      redirect_to("/courses/#{@the_course.id}", { :alert => "Course failed to update successfully." })
    end
  end

  def create
    c = Course.new
    c.title = params.fetch("query_title")
    c.term_offered = params.fetch("query_term_offered")

    if c.valid?
      c.save
      redirect_to("/courses", { :notice => "Course created successfully." })
    else
      redirect_to("/courses", { :notice => "Course failed to create successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    matching_records = Course.where({ :id => the_id })
    the_course = matching_records.at(0)
    the_course.destroy

    redirect_to("/courses", { :notice => "Course deleted successfully."} )
  end

  def index
    matching_courses = Course.all
    @list_of_courses = matching_courses.order({ :created_at => :desc })

    render({ :template => "courses/index" })
  end

  def show
    the_id = params.fetch("path_id")
    
    matching_courses = Course.where({:id => the_id })
    @the_course = matching_courses.at(0)

    render({ :template => "courses/show" })
  end
end
