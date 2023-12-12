import 'dart:math';

import 'package:custom_card_flip/utils/text_utils.dart';
import 'package:flutter/material.dart';

import '../data/color_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  /// AnimationController to Controller flip animation
  late final AnimationController _controller;
  /// TextEditingController  for TextFeilds
  final  TextEditingController _numberController=TextEditingController();
  final  TextEditingController _nameController=TextEditingController();
  final  TextEditingController _monthController=TextEditingController();
  final  TextEditingController _yearController=TextEditingController();
  final  TextEditingController _cvvController=TextEditingController();
  ///  selectedIndex is for background gradient color
  int selectedIndex=0;
  /// selectedCompany is for company mastercard or visa
  int selectedCompany=0;

  void initState() {
    /// Initializing the AnimationController with duration
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    ); // <-- Set your duration here.
  }
  /// dispose all controllers to prevent memory leak
  @override

  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _numberController.dispose();
    _nameController.dispose();
    _monthController.dispose();
   _yearController.dispose();
   _cvvController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  SafeArea(
        /// SingleChildScrollView is used to prevent the overflow error while using the keyboard
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          /// MediaQuery.of(context).size.height-50, used because we are using spacer widget
          child: SizedBox(
            height: MediaQuery.of(context).size.height-50,
            child: Column(
              children: [
               const  SizedBox(height: 20,),
                /// AnimatedBuilder for Card flip And Animation
                AnimatedBuilder(
                  /// _controller for animation
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    /// To flip the card we are using the Transform widget
                    /// with  Matrix4.identity()
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..setEntry(3,2, 0.001)..rotateY((_controller.value<0.5)?pi*_controller.value:(pi*(1+_controller.value))),

                    child: Card(
                    clipBehavior: Clip.antiAlias,
                      child: Container(
                        height: 210,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientList[selectedIndex]
                          )
                        ),
                        /// here  we are checking the condition on  which we change our frontCard and backCard
                        child:(_controller.value<0.5)?frontCard():backCard(),
                      ),
                    ),
                  );}
                ),
              const  SizedBox(height: 10,),
                /// //////////  Company Selection /////////
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedCompany=0;
                        });

                      },
                      child: Container(
                        padding:const  EdgeInsets.all(10),
                        height: 40,width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color:selectedCompany==0? gradientList[selectedIndex][0]: Colors.grey)

                        ),
                        child: Image.asset("assets/logo1.png"),

                      ),
                    ),
                   const  SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedCompany=1;
                        });

                      },
                      child: Container(
                        padding:const  EdgeInsets.all(10),
                        height: 40,width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color:selectedCompany==1? gradientList[selectedIndex][0]: Colors.grey)

                        ),
                        child: Image.asset("assets/logo2.png"),

                      ),
                    ),
                  ],
                ),


//////////////// Input Fields ////////////////
                Field( _nameController,  'Card Holder Name',true),
                Field( _numberController,  'Card Number', false,),
                Row(
                  children: [
                    Expanded(child: Field( _monthController,  'MM', false,)),
                   const  SizedBox(width: 15,),
                    Expanded(child: Field( _yearController,  'YY', false,)),
                    const  SizedBox(width: 15,),
                    Expanded(child: Field( _cvvController,  'CVV', false,)),
                  ],
                ),
              const  SizedBox(height: 50,),
               ////////////// Colors Selection section ///////////////
               SizedBox(
                 height: 20,
                 child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                     itemCount: gradientList.length,
                     itemBuilder: (context,index){

                     return GestureDetector(
                       onTap: (){
                         setState(() {
                           selectedIndex=index;
                         });

                       },
                       child: Stack(

                         children: [
                           Container(
                             height: 20,
                             width: 20,
                             margin: const EdgeInsets.only(right: 25),
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               gradient: LinearGradient(
                                 colors: gradientList[index]
                               )
                             ),
                           ),
                         selectedIndex==index? const  Icon(Icons.done,color: Colors.white,size: 19,):const SizedBox()
                         ],
                       ),
                     );

                 }),
               ),
               const Spacer(),
////////////////////// Save BTn ////////////////////////
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors:  gradientList[selectedIndex]
                )

                ),
                alignment: Alignment.center,
                child: TextUtil(text: "Save",),
              )

              ],
            ),
          ),
        ),
      ),

    );
  }
///////////////////////// frontView Of Our Card //////////////
  Widget frontCard(){
    return Stack(

      children: [
        Image.asset("assets/world.png",color: gradientList[selectedIndex][0],),
        Container(


          padding: const EdgeInsets.only(right: 15,top: 10,bottom: 10,left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             TextUtil(text: "Credit Card",size: 20,),
            const Spacer(),
            Container(height: 50,
            width: 60,
            decoration:const  BoxDecoration(

              image: DecorationImage(image: AssetImage("assets/chip.png"),fit: BoxFit.fill,)

            ),),
              const Spacer(),
              TextUtil(text: _numberController.text,size: 20,),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,


                children: [
              Expanded(child:     Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          TextUtil(text: "Valid",size: 10,weight: true,),
                          TextUtil(text: "${_monthController.text}/${_yearController.text}",size: 14,),
                        ],

                      ),
                      const SizedBox(width: 20,),
                    ],

                  ),
                 const  SizedBox(height: 10,),

                  TextUtil(text: _nameController.text,size: 15,weight: true,),
                 const  SizedBox(height: 5,),
                ],
              ),),
                  SizedBox(height: 40,width: 90,
                    child: Image.asset(selectedCompany==0?"assets/logo1.png":"assets/logo2.png",fit: BoxFit.fill,),
                    
                  )
                ],
              )

            ],
          ),
        ),
      ],
    );

  }
///////////////////////// backView  Of Our Card //////////////
  Widget backCard(){
    return Stack(

      children: [
        Image.asset("assets/world.png",color: gradientList[selectedIndex][0]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const  SizedBox(height: 20,),
            Container(height: 50,
            width: double.infinity,
            color: Colors.black,),
            const  SizedBox(height: 20,),
            Container(
              margin:const  EdgeInsets.symmetric(horizontal: 20),
              padding:const  EdgeInsets.symmetric(horizontal: 10),
              height: 50,

              width: double.infinity,
              color: Colors.grey.shade300,
              alignment: Alignment.centerRight,
              child: TextUtil(text: _cvvController.text,color: Colors.black,weight: true,),

            ),
       const   Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextUtil(text: "A credit card is a thin rectangular piece of plastic or metal issued by a bank or financial services company that allows cardholders to borrow funds with which to pay for goods and services with merchants that accept cards for payment.",size:9,),
            ),
          const   Spacer(),








          ],
        ),
      ],
    );

  }
  /////// Custom Field widget to handel the user input
  Widget Field(TextEditingController controller,String hinttext, bool isNumberType) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset:const  Offset(2,2),
                blurRadius: 2),
            BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(-2,-2),
                blurRadius: 2)]
      ),


      child: TextFormField(
        /// keyboardType

        keyboardType: isNumberType?TextInputType.emailAddress:TextInputType.number,
        ///controller
        controller: controller,
        ///controller
        maxLines: 1,
         /// onTap
        onTap: (){
          /// here we are checking the condition with hinttext
          if(hinttext=="CVV") {
            /// Animation Start
            _controller.forward();
          } else{
            /// Animation revers
            _controller.reverse();
          }

        },
        /// onChanged
        onChanged: (value){
          /// Using the setState to Update UI As soon As the value Changes

          setState(() {

          });
        },
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey.shade400),
            hintText: hinttext,
            border: InputBorder.none
        ),
      ),
    );
  }
}

