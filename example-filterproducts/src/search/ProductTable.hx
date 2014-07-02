package search;
import react.React;
using Lambda;

class  ProductTable   extends React
{
	public function render() 
	{
		var rows = [];
		var lastCategory = null;		
		
		var products:Array<Dynamic> = cast  this.props.products;
		
		products.iter(function (product) 
		{
			if (product.name.indexOf(this.props.filterText)  == -1  || (! product.stocked && this.props.inStockOnly)) return;
			
			if (product.category != lastCategory) {
				rows.push( @dom '
					<search.ProductCategoryRow category={product.category} key={product.category} />
				');
			}
			
			rows.push(@dom '
				<search.ProductRow product={product} key={product.name} />
			');
			
			lastCategory = product.category;
		});	   

		return @dom '	
			<table>
				<thead>
					<tr>
						<th>Name</th>
						<th>Price</th>
					</tr>
				</thead>
				<tbody>{rows}</tbody>
			</table>
		';
	}
}