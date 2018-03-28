Q: What classes does each implementation include? Are the lists the same?
A: Each implementation includes the same classes: CartEntry, ShoppingCart, and Order.

Q: Write down a sentence to describe each class.
A: For both implementations, the CartEntry class represents an item being added to an order, and takes in two arguments: unit_price and quantity. The ShoppingCart class is the 'higher level' class and it holds an array of cart entries. The Order class initializes a new instance of ShoppingCart and is able to calculate total_price of the order, factoring in sales_tax, a constant.

Q: How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
A: The classes in Implementation A are more tightly coupled than the classes in Implementation B. In A, the CartEntry and ShoppingCart classes have only states and no unique behavior, and they use attr_accessors for their instance variables, making them readable and writable from outside the class. The Order class has a total_price method that directly manipulates the two other class' instance variables through an each loop.
Implementation B has no attr_accessors and each class has its own method to calculate price for itself and send those messages to each other.
Both A & B call the ShoppingCart class directly by it's name in Order's constructor, and instance creation might be better off in it's own helper method?

Q: What data does each class store? How (if at all) does this differ between the two implementations?
A: Both implementations have an 'entries' instance variable which I assume holds a collection (array) of CartEntry objects. Both also have a constant called SALES-TAX which holds a float, and the CartEntry initialize method in both takes in a unit_price and quantity, data which is then stored in the corresponding instance variables.

Q: What methods does each class have? How (if at all) does this differ between the two implementations?
A: As I mentioned above, in Implementation A the behavior for the whole system is concentrated in the Order class, where the total_price method accesses information from the other two classes to calculate the total sum for the order. Implementation B, however, adds a price method to both the CartEntry class and the ShoppingCart class, which helps DRY up the total_price method in the Order class, and adheres more to SRP.

Consider the Order#total_price method. In each implementation:

Q: Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
A:
Q: Does total_price directly manipulate the instance variables of other classes?
A:
Q: If we decide items are cheaper if bought in bulk, how would this change the code? A:
Q: Which implementation is easier to modify?
A:
Q: Which implementation better adheres to the single responsibility principle?
A:
Q: Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled
A:


Few questions about Hotel Revisited... In the design-activity set of questions, what does it mean in the first question when it asks "Are the lists the same?". What lists?...Also second question about writing a sentence to describe each class: are you asking us to describe both Implementations separately, or just describe generally what each class is doing across both Implementations?
