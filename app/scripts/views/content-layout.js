// Generated by CoffeeScript 1.7.1
var ContentLayout,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

ContentLayout = (function(_super) {
  __extends(ContentLayout, _super);

  function ContentLayout() {
    return ContentLayout.__super__.constructor.apply(this, arguments);
  }

  ContentLayout.prototype.attributes = {
    id: 'contentLayout-layout'
  };

  ContentLayout.prototype.template = '<div>' + '<div id="chart" class="col-md-8">test chart</div>' + '<div id="meta" class="col-md-4">test meta</div>' + '</div>';

  ContentLayout.prototype.regions = {
    chart: '#chart',
    meta: '#meta'
  };

  return ContentLayout;

})(Marionette.LayoutView);

module.exports = ContentLayout;
