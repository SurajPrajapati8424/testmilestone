/*
📦 Add widget elements to your tooltip
↔️ Chose the preferred position for the tooltip to appear relative to the button
↩️ The position changes automagically if the desired one doesn't fit the screen
✅ No external dependencies
❤️ Customizable layout
🛡️ Null safety
 */

import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';

class TooltipExample extends StatelessWidget {
  const TooltipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ElTooltip Demo')),
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ElTooltip(
                  content: tooltipContent,
                  color: Color(0XFFEA4747),
                  showModal: false,
                  child: tooltipIcon,
                ),
                Spacer(),
                ElTooltip(
                  content: tooltipContent,
                  color: Color(0XFFEA4747),
                  child: tooltipIcon,
                ),
                Spacer(),
                ElTooltip(
                  content: tooltipContent,
                  color: Color(0XFFEA4747),
                  child: tooltipIcon,
                ),
              ],
            ),
            Row(
              children: [
                ElTooltip(
                  content: tooltipContent,
                  color: Color(0XFFEA4747),
                  child: tooltipIcon,
                ),
                Spacer(),
                ElTooltip(
                  content: tooltipContent,
                  color: Color(0XFFEA4747),
                  child: tooltipIcon,
                ),
                Spacer(),
                ElTooltip(
                  content: tooltipContent,
                  color: Color(0XFFEA4747),
                  child: tooltipIcon,
                ),
              ],
            ),
            Row(
              children: [
                ElTooltip(
                  content: tooltipContent,
                  color: Color(0XFFEA4747),
                  child: tooltipIcon,
                ),
                Spacer(),
                ElTooltip(
                  content: tooltipContent,
                  color: Color(0XFFEA4747),
                  child: tooltipIcon,
                ),
                Spacer(),
                ElTooltip(
                  content: tooltipContent,
                  color: Color(0XFFEA4747),
                  child: tooltipIcon,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const tooltipContent = Text(
  'Hola Mundo!',
  style: TextStyle(color: Colors.white),
  textAlign: TextAlign.center,
);

const tooltipIcon = Icon(
  Icons.info,
  color: Color(0XFFA5A53A),
);
