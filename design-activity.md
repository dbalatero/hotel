Q: What classes does each implementation include? Are the lists the same?
A: Each implementation includes the same classes: CartEntry, ShoppingCart, and Order. Not sure what is meant by 'lists'.

Q: Write down a sentence to describe each class.
A: For both implementations, the CartEntry class represents an item being added to an order, and takes in two arguments: unit_price and quantity. The ShoppingCart class holds an array of CartEntries. The Order class initializes a new instance of ShoppingCart and is able to calculate total_price of the order, factoring in sales_tax, a constant.

Q: How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
A: The classes in Implementation A are more tightly coupled than the classes in Implementation B. In A, the CartEntry and ShoppingCart classes have only states and no unique behavior, and they use attr_accessors for their instance variables, making them readable and writable from outside the class. The Order class has a total_price method that directly manipulates the two other class' instance variables through an each loop.
Implementation B has no attr_accessors and each class has its own method to calculate price for itself and send those messages to the other classes.
Both A & B call the ShoppingCart class directly by it's name in Order's constructor, and instance creation might be better off in it's own helper method?

Q: What data does each class store? How (if at all) does this differ between the two implementations?
A: Both implementations have an 'entries' instance variable which I assume holds a collection (array) of CartEntry objects. Both also have a constant called SALES-TAX which holds a float, and the CartEntry initialize method in both takes in a unit_price and quantity, data which is then stored in the corresponding instance variables. The cart instance variable also holds an instance of ShoppingCart. There doesn't appear to be a large difference between data storage across the two implementations.

Q: What methods does each class have? How (if at all) does this differ between the two implementations?
A: As I mentioned above, in Implementation A the behavior for the whole system is concentrated in the Order class, where the total_price method accesses information from the other two classes to calculate the total sum for the order. Implementation B, however, adds a price method to both the CartEntry class and the ShoppingCart class, which helps DRY up the total_price method in the Order class, and adheres more to the single responsibility principle.

Consider the Order#total_price method. In each implementation:

Q: Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
A: In A, the logic to compute price is retained in Order, whereas in B, the logic is delegated across all classes.

Q: Does total_price directly manipulate the instance variables of other classes?
A: In Implementation A, total_price does directly manipulate the instance variables of other classes, whereas B does not - it receives a message from cart, which receives a message from CartEntry.

Q: If we decide items are cheaper if bought in bulk, how would this change the code?
A: When items are purchased in bulk, typically the unit cost goes down as the quantity increases. Therefore, in Implementation B, in CartEntry's price method we would have to build in some conditional logic to check if 'quantity' was above a certain amount, and if so, then multiply the unit price by a percentage like .40 to reduce the per unit cost, then multiply that by the quantity. For Implementation A, similar logic would need to be added to the total_price method in Order, which would make the method a bit too long and doing things it shouldn't be doing, violating SRP.

Q: Which implementation is easier to modify?
A: I believe B is easier to modify.

Q: Which implementation better adheres to the single responsibility principle?
A: Implementation B.

Q: Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled
A: Implementation B is more loosely coupled because it has fewer dependencies and each class adheres more to SRP and knows less about the other objects.
