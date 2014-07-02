package ;

import haxe.Json;
import js.Lib;
import react.React;
import search.FilterableProductTable;
import search.ProductCategoryRow;
import search.ProductRow;
import search.ProductTable;
import search.SearchBar;
using Lambda;

class App extends React
{	
	static function main() 
	{
		React.renderComponent(
			@dom '<App />',
			 js.Browser.document.body
		);
	}
	
	  var products = [
		  {category: 'Sporting Goods', price: '$49.99', stocked: true, name: 'Football'},
		  {category: 'Sporting Goods', price: '$9.99', stocked: true, name: 'Baseball'},
		  {category: 'Sporting Goods', price: '$29.99', stocked: false, name: 'Basketball'},
		  {category: 'Electronics', price: '$99.99', stocked: true, name: 'iPod Touch'},
		  {category: 'Electronics', price: '$399.99', stocked: false, name: 'iPhone 5'},
		  {category: 'Electronics', price: '$199.99', stocked: true, name: 'Nexus 7'}
		];	
		
	public function render() 
	{
		return @dom '
			<div>
				<search.FilterableProductTable  products={this.products}/>
			</div>
		';
	}	
}




