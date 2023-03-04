import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@GenerateMocks([], customMocks: [
  MockSpec<FirebaseAuth>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<UserCredential>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<User>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FirebaseFirestore>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<QuerySnapshot>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<CollectionReference>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DocumentReference>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<Query>(onMissingStub: OnMissingStub.returnDefault),
])
class TestMocks {}
