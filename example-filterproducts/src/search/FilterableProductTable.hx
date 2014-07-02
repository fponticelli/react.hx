package search;
import react.React;


class  FilterableProductTable extends React
{
	override public function getInitialState() 
	{
		return {
			filterText: '',
			inStockOnly: false,
		};
	  }	
	  
	  public function handleUserInput(filterText, inStockOnly)
	  {
		  this.setState( {
			filterText:filterText,
			inStockOnly: inStockOnly,
		  });
	  }
	
	public function render() 
	{
		return @dom '	
			<div>				
				<search.SearchBar 
					filterText={this.state.filterText}
					inStockOnly={this.state.inStockOnly}
					onUserInput={this.handleUserInput}			    
				/>
				<search.ProductTable 
					products = { this.props.products } 
					filterText={this.state.filterText}
					inStockOnly={this.state.inStockOnly}			    
				/>
			</div>		
		';
	}
}