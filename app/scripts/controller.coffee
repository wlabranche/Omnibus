# Require Views and Models
WelcomeView = require './views/welcome-view.coffee'
SearchView = require './views/search-view.coffee'
ContentLayout = require './views/content-views/content-layout.coffee'
ChartView = require './views/content-views/chart-view.coffee'
SearchResults = require './views/content-views/search-results-view.coffee'
MetaLayout = require './views/meta-views/meta-layout.coffee'
MetaView = require './views/meta-views/meta-view.coffee'
BillModel = require './models/bill-model.coffee'
BillsCollection = require './collections/bills-collection.coffee'


class MainController extends Marionette.Controller
  initialize: ( options ) ->

  getData: ( billId )->
    
    deferred = new $.Deferred()

    if not window.localStorage.getItem billId
      billModel = new BillModel id: billId
      billModel.fetch().then ( res ) ->
        window.localStorage.setItem billId, res
        deferred.resolve( billModel )
    else
      billModel = new BillModel JSON.parse window.localStorage.getItem billId
      deferred.resolve( billModel )

    deferred.promise()


  showBill: ( id ) ->
    @getData( id ).then ( billModel ) =>
      @showAll billModel

  home: ->
    currentCongress = 113
    firstBill = 'hr2397'
    firstBillId = currentCongress + '-' + firstBill
    @getData( firstBillId ).then ( billModel ) =>
      @showAll billModel

  welcomeView: ( billModel ) ->
    welcomeView = new WelcomeView model: billModel
    $('#information').hide()

    @listenTo welcomeView, 'welcome:close', ->
      @options.regions.welcome.empty()
      $('#information').show()

    @options.regions.welcome.show welcomeView

  searchView: ( billModel ) ->
    searchView = new SearchView model: billModel

    @listenTo searchView, 'findBill:submit', ( billId ) ->
      @router.navigate 'bill/' + billId, {trigger: true}

    @listenTo searchView, 'welcome:show', ->
      @welcomeView searchView.model

    @listenTo searchView, 'search:bills:submit', ( query ) ->
      @searchResults( query )

    @options.regions.search.show searchView

  searchResults: ( query ) ->
    that = @
    billsCollection = 'unknown'
    searchResults = 'unknown'
    $.ajax
      url: 'http://omnibus-backend.azurewebsites.net/api/bills/search?q=' + query
      data: JSON
    .then ( data ) -> 
      data = JSON.parse( data ).results
      billsCollection = new BillsCollection data
    .then ( data ) ->
      # Make composite view with bills collection
      searchResults = new SearchResults collection: billsCollection
      # Listen for click on itemView bill result
      that.listenTo searchResults, 'bill:submit', ( billId ) ->
        # that.showBill( billId )
        that.router.navigate 'bill/' + billId, { trigger: true }
      # Show composite view
      that.options.regions.content.show searchResults


  showAll: ( billModel ) ->
    @searchView billModel

    if not window.localStorage.getItem 'omnibus-visited'
      @welcomeView billModel
      window.localStorage.setItem 'omnibus-visited', true

    contentLayout = new ContentLayout
    @options.regions.content.show contentLayout

    chartView = new ChartView model: billModel
    contentLayout.chart.show chartView

    metaLayout = new MetaLayout
    contentLayout.meta.show metaLayout
    
    sponsor = new MetaView model: billModel
    sponsorTwo = new MetaView model: billModel
    sponsorThree = new MetaView model: billModel
    metaLayout[ 'meta1' ].show sponsor
    metaLayout[ 'meta2' ].show sponsorTwo
    metaLayout[ 'meta3' ].show sponsorThree
    


module.exports = MainController
