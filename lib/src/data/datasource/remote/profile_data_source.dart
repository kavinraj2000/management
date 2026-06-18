<<<<<<< HEAD

import 'package:tvkapp/src/core/network/dio_network.dart';
=======
// lib/data/datasources/remote/profile_remote_datasource.dart


import 'package:profilediscovery/src/core/network/dio_network.dart';
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

abstract class ProfileRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchProfiles({
    int page = 1,
    int results = 10,
    String? gender,
    String? nationality,
  });

  Future<Map<String, dynamic>> fetchProfileById(String id);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient _dioClient;

  ProfileRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<Map<String, dynamic>>> fetchProfiles({
    int page = 1,
    int results = 10,
    String? gender,
    String? nationality,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'results': results,
        'seed': 'profilehub',
      };

      if (gender != null && gender != 'All') {
        queryParams['gender'] = gender.toLowerCase();
      }
      if (nationality != null) {
        queryParams['nat'] = nationality;
      }

      final response = await _dioClient.get('/', queryParameters: queryParams);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;
        return results
            .map((item) => _mapApiResponseToProfile(item))
            .toList();
      }
      throw const ServerException('Failed to fetch profiles');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> fetchProfileById(String id) async {
    try {
      final response = await _dioClient.get('/', queryParameters: {
        'seed': id,
        'results': 1,
      });

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;
        if (results.isNotEmpty) {
          return _mapApiResponseToProfile(results.first);
        }
      }
      throw const ServerException('Profile not found');
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _mapApiResponseToProfile(Map<String, dynamic> item) {
    final name = item['name'] as Map<String, dynamic>;
    final location = item['location'] as Map<String, dynamic>;
    final login = item['login'] as Map<String, dynamic>;
    final picture = item['picture'] as Map<String, dynamic>;
    final dob = item['dob'] as Map<String, dynamic>;

    final city = location['city'] as String? ?? '';
    final country = location['country'] as String? ?? '';

    return {
      'id': login['uuid'] as String,
      'full_name': '${name['first']} ${name['last']}',
      'email': item['email'] as String? ?? '',
      'phone': item['phone'] as String? ?? '',
      'occupation': _generateOccupation(login['uuid'] as String),
      'location': '$city, $country',
      'about_me': _generateAboutMe(name['first'] as String),
      'age': (dob['age'] as num?)?.toInt() ?? 25,
      'profile_picture': picture['large'] as String? ?? '',
      'gender': item['gender'] as String? ?? '',
      'is_favorite': 0,
      'cached_at': DateTime.now().toIso8601String(),
    };
  }

  // Generate realistic mock data
  String _generateOccupation(String seed) {
    final occupations = [
      'Software Engineer',
      'Product Designer',
      'Data Scientist',
      'Marketing Manager',
      'Financial Analyst',
      'UX Researcher',
      'DevOps Engineer',
      'Content Creator',
      'Business Developer',
      'Graphic Designer',
      'Project Manager',
      'Full Stack Developer',
    ];
    final index = seed.codeUnits.fold(0, (a, b) => a + b) % occupations.length;
    return occupations[index];
  }

  String _generateAboutMe(String firstName) {
    final bios = [
      'Passionate about technology and innovation. Love exploring new ideas and connecting with like-minded people.',
      'Creative thinker with a knack for problem-solving. Always looking for ways to make the world a better place.',
      'Adventure seeker and lifelong learner. Believe in the power of collaboration and community.',
      'Driven professional with a passion for excellence. Love building meaningful products that matter.',
    ];
    final index = firstName.length % bios.length;
    return bios[index];
  }
}