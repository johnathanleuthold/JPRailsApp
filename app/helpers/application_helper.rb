module ApplicationHelper
    ###########################################################################
    # Defines the bahavior of the title bar for each page
    # If no title is provided for the page only the base title is shown
    # otherwise both the page title and base title are shown seperated by a |
    #
    # Entry: page title is provided by the view for each page
    #        base title is the site name
    #
    #  Exit: page title set
    ###########################################################################
  def full_title(page_title = '')
    base_title = "Cooking with Engineers"
    if(page_title.empty?)
        base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  
  def get_form
    "#{controller.controller_name}/form"
  end
end
