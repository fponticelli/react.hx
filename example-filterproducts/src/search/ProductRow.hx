package search;
import react.React;

class  ProductRow  extends React
{
	public function render() 
	{
		var name = this.props.product.stocked ? this.props.product.name : @dom '< span style = {{ color: "red" }} >{this.props.product.name}</span>';		
		
		return @dom '	
			<tr>
				<td>{name}</td>
				<td>{this.props.product.price}</td>
			</tr>	
		';
	}
}