import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://media-exp1.licdn.com/dms/image/C4D03AQGdgnVP8VxJZw/profile-displayphoto-shrink_800_800/0?e=1612396800&v=beta&t=I_GCuCz7icQzw0miZqVKQGw8PQoqhQ3BHBBV4j2zXfc"),
                      fit: BoxFit.cover)),
              child: Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: Alignment(0.0, 2.5),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://media-exp1.licdn.com/dms/image/C4D03AQGdgnVP8VxJZw/profile-displayphoto-shrink_800_800/0?e=1612396800&v=beta&t=I_GCuCz7icQzw0miZqVKQGw8PQoqhQ3BHBBV4j2zXfc"),
                        radius: 60.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Sonu Simon",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Thrissur Railway Station, India",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "CEO Google",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            // /Contact
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      print("WhatsApp");
                    }),
                IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      print("Calling...");
                    }),
                Icon(
                  Icons.assignment_turned_in_outlined,
                  color: Colors.red,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: Text("Details"),
              children: [
                ListTile(
                  title: Text("Name"),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text('Details'),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                        ),
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Phone',
                                        ),
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Locality',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                RaisedButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      // your code
                                    })
                              ],
                            );
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Phone Number"),
                        Text("Locality"),
                        Text("Email ID"),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),

            ExpansionTile(
              title: Text("Your Posts"),
              children: [
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      return del_post_dialogue(context);
                    },
                  ),
                  title: Text("Post Title"),
                  trailing: IconButton(
                    icon: Icon(Icons.message_outlined),
                    onPressed: () {
                      return edit_post_dialogue(context);
                    },
                  ),
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      print("Saanam Kalanju");
                    },
                  ),
                  title: Text("Post Title 2"),
                  trailing: IconButton(
                    icon: Icon(Icons.message_outlined),
                    onPressed: () {
                      print("ChangeForm");
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future edit_post_dialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Alert"),
              content: Text("Do you want to edit your post"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Okay")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Cancel"))
              ],
            ));
  }

  Future del_post_dialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Alert"),
              content: Text("Are you sure you want to delete your post"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Okay")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Cancel"))
              ],
            ));
  }
}
