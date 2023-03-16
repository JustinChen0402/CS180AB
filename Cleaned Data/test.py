class MyClass:
    class_attribute = 'class_value'

    def __init__(self):
        self.attribute1 = 'value1'
        self.attribute2 = 'value2'

    def method1(self):
        print('method1 called')

my_obj = MyClass()

# list the instance variables
for attribute_name in dir(my_obj):
    if not hasattr(MyClass, attribute_name):
        print(attribute_name)
