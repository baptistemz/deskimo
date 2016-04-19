var CompaniesListItem = React.createClass({
  render: function() {
    return (
      <div className="product-thumbnail">
        <div className="product-thumbnail-gradient"><h4>détails</h4></div>
        <img className="img-responsive full-width" src={this.props.company.picture} alt="Mutualab" />
        <div className="distance">
          <p>{this.props.company.distance} km</p>
        </div>
        <ul className="list-unstyle list-inline" id="services">
        if (this.props.company.wifi){
          <li><div className="service-badge"><i className="fa fa-wifi"></i></div></li>
        }
        if (this.props.company.coffee){
          <li><div className="service-badge"><i className="fa fa-coffee"></i></div></li>
        }
        if (this.props.company.printer){
          <li><div className="service-badge"><i className="fa fa-print"></i></div></li>
        }
        </ul>
        <div className="product-thumbnail-content">
          <div className="product-name"><p>Mutualab</p></div>
          <div className="office-kind"><p className="small-font">à partir de :</p></div>
          <div className="product-price"><p>30€ / j</p></div>
        </div>
      </div>
    );
  }
});
