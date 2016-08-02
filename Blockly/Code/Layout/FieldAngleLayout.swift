/*
 * Copyright 2016 Google Inc. All Rights Reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

/**
 Class for a `FieldAngle`-based `Layout`.
 */
@objc(BKYFieldAngleLayout)
public class FieldAngleLayout: FieldLayout {

  // MARK: - Properties

  /// The `FieldAngle` that backs this layout
  public let fieldAngle: FieldAngle

  /// The text value that should be used when rendering this layout
  public var textValue: String {
    return String(fieldAngle.angle) + "°"
  }

  // MARK: - Initializers

  public init(angle: FieldAngle, engine: LayoutEngine, measurer: FieldLayoutMeasurer.Type) {
    self.fieldAngle = angle
    super.init(field: fieldAngle, engine: engine, measurer: measurer)

    fieldAngle.delegate = self
  }

  // MARK: - Super

  // TODO:(#114) Remove `override` once `FieldLayout` is deleted.
  public override func didUpdateField(field: Field) {
    // Perform a layout up the tree
    updateLayoutUpTree()
  }

  // MARK: - Public

  /**
   Updates `self.fieldAngle` from the given text value. If the value was changed, the layout tree
   is updated to reflect the change.

   - Parameter text: A valid integer that will be used to update `self.fieldAngle`. If this value
   is not a valid integer, `self.fieldAngle` is not updated.
   */
  public func updateAngle(fromText text: String) {
    if let newAngle = Int(text) { // Only update it if it's a valid value
      // Setting to a new angle automatically fires a listener to update the layout
      fieldAngle.angle = newAngle
    }
  }
}
