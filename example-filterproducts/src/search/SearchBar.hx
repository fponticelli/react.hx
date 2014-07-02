package search;
import react.React;


class  SearchBar  extends React
{
	function handleChange() 
	{
		this.props.onUserInput(
			this.refs.filterTextInput.getDOMNode().value,
			this.refs.inStockOnlyInput.getDOMNode().checked
			);
	}
	
	
	public function render() 
	{
		return @dom '	
			<form>
				< input 
					type = "text" 
					placeholder="Search..." 
					value={this.props.filterText}
					ref="filterTextInput"
					onChange={this.handleChange}			    
				/>

				<p>
					< input 
						type = "checkbox" 
						checked={this.props.inStockOnly}
						ref="inStockOnlyInput"
						onChange={this.handleChange}			        
					/>
				Only show products in stock
				</p>
			</form>	
		';
	}
}