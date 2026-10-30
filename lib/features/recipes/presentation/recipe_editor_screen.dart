import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../data/recipes_dao.dart';
import 'recipe_editor_form.dart';

/// One-shot load (not a stream) so saving never rewrites the form under the user.
final _editorDataProvider = FutureProvider.autoDispose
    .family<RecipeDetail?, int>(
      (ref, id) => ref.read(recipesDaoProvider).getRecipeDetail(id),
    );

/// Create ([recipeId] == null) or edit a recipe.
///
/// Pops with `true` only when the recipe was deleted from the editor.
class RecipeEditorScreen extends ConsumerWidget {
  const RecipeEditorScreen({super.key, this.recipeId});

  final int? recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = recipeId;
    final title = Text(id == null ? 'New recipe' : 'Edit recipe');
    if (id == null) {
      return Scaffold(
        appBar: AppBar(title: title),
        body: const RecipeEditorForm(),
      );
    }
    return Scaffold(
      appBar: AppBar(title: title),
      body: ref
          .watch(_editorDataProvider(id))
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Could not load recipe: $e')),
            data: (detail) => detail == null
                ? const Center(child: Text('This recipe no longer exists.'))
                : RecipeEditorForm(initial: detail),
          ),
    );
  }
}
