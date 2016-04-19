var CompaniesList = React.createClass({
  render: function() {
    return (
      <div>
        {this.props.companies.map(function(company){
          return <CompaniesListItem company={company} />;
        })}
      </div>
    );
  }
});
