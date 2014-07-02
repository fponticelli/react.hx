package search;

import react.React;



class  ProductCategoryRow   extends React
{
	public function render() 
	{
		return @dom '
			<tr>
				<th colSpan="2">{this.props.category}</th>
			</tr>
		';
	}
}

