define [ "marionette", "config/event_handler", "views/layouts/ablass"], ( Marionette, EventHandler, Layout, HomeView)->
  
  class ApplicationController extends Marionette.Controller
    
    initialize: ( app )->
      @app = app
      Layout.render()
      $("body").prepend(Layout.el);

    homeRoute: ()->
      require ["views/home-view"], (HomeView)->
        myHomeView = new HomeView()
        Layout.content.show( myHomeView )
    sinsRoute: ()->
      router = @app.router
      require ["views/sins/page-view", "fixtures/sins"], (SinsPageView, sins)->
        mySinsPageView = new SinsPageView( sins )
        Layout.content.show( mySinsPageView )

        # This should be inside the SinItemView but it's not responding because the object is not yet in the DOM
        # There is a need to refactor this if the list become more complex
        $("ul li.sin_item").click ()->
          router.navigate("sin/#{@id}/projects", {trigger: true })

    sinsProjectsRoute: (id)->
      router = @app.router
      require ["views/projects/page-view", "fixtures/projects"], (ProjectsPageView, projects)->
        myProjectsPageView = new ProjectsPageView( projects )
        Layout.content.show( myProjectsPageView )

        # # This should be inside the SinItemView but it's not responding because the object is not yet in the DOM
        # # There is a need to refactor this if the list become more complex
        $("ul li.project_item").click ()->
          router.navigate("/projects/#{@id}", {trigger: true })

    projectRoute: (id)->
      require ["views/projects/show-view", "models/project", "fixtures/projects"], (ProjectView, Project, projects)->
        project = new Project( projects[0] )
        myProjectView = new ProjectView( model: project )
        Layout.content.show( myProjectView )
        $("button.donate").click ()->
          window.location.href =  "https://www.bp42.com/en/projects/632/client_donations/new?client_id=ablass"

    donationSuccessRoute: ()->
      console.log "here"
      require ["views/success-view"], (SuccessView)->
        mySuccessView = new SuccessView()
        Layout.content.show( mySuccessView )

    changePage: ()->
      console.log "changing page"
