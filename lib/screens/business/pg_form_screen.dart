import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PgFormScreen extends StatefulWidget {
  @override
  _PgFormScreenState createState() => _PgFormScreenState();
}

class _PgFormScreenState extends State<PgFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedImagePath;
  final ImagePicker _picker = ImagePicker();
  
  // List of available PG images from assets
  final List<String> _pgImages = [
    'assets/images/pg_images/pg1.jpg',
    'assets/images/pg_images/pg2.jpg',
    'assets/images/pg_images/pg3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    print('Initializing PG Form Screen');
    // Try to load a test image
    _loadTestImage();
  }

  void _loadTestImage() async {
    try {
      // Try to load the first image to verify asset loading
      final image = AssetImage(_pgImages[0]);
      await precacheImage(image, context);
      print('Successfully loaded test image: ${_pgImages[0]}');
    } catch (e) {
      print('Error loading test image: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImagePath = image.path;
          print('Selected image from gallery: $_selectedImagePath');
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _selectImageFromAssets(String imagePath) {
    print('Selecting image from assets: $imagePath');
    setState(() {
      _selectedImagePath = imagePath;
    });
  }

  Widget _buildImagePreview() {
    print('Building image preview with path: $_selectedImagePath');
    if (_selectedImagePath == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_photo_alternate, size: 50),
          SizedBox(height: 8),
          Text('Tap to add PG image'),
        ],
      );
    }

    if (_selectedImagePath!.startsWith('assets/')) {
      return Image.asset(
        _selectedImagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading asset image: $error');
          print('Stack trace: $stackTrace');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 50, color: Colors.red),
                Text('Error loading image'),
                Text('Path: $_selectedImagePath'),
              ],
            ),
          );
        },
      );
    } else {
      return Image.file(
        File(_selectedImagePath!),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading file image: $error');
          print('Stack trace: $stackTrace');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 50, color: Colors.red),
                Text('Error loading file'),
                Text('Path: $_selectedImagePath'),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add PG Details'),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Selected Image Preview
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildImagePreview(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Available PG Images Gallery
              Text(
                'Available PG Images',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _pgImages.length,
                  itemBuilder: (context, index) {
                    print('Building gallery item for image: ${_pgImages[index]}');
                    return GestureDetector(
                      onTap: () => _selectImageFromAssets(_pgImages[index]),
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _selectedImagePath == _pgImages[index]
                                ? Colors.deepPurple
                                : Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            _pgImages[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print('Error loading gallery image ${_pgImages[index]}: $error');
                              print('Stack trace: $stackTrace');
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error, size: 30, color: Colors.red),
                                    Text('Error'),
                                    Text('Path: ${_pgImages[index]}'),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'PG Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PG name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price per month',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _selectedImagePath != null) {
                    // TODO: Implement form submission logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('PG details saved successfully')),
                    );
                    Navigator.of(context).pop();
                  } else if (_selectedImagePath == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a PG image')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Save PG Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
